import { Module } from '@nestjs/common';
import { EmailService } from './email.service';
import { MailerModule } from '@nestjs-modules/mailer';

@Module({
  imports:[//Модуль главной страницы
  MailerModule.forRoot({
      transport:{
          host: 'smtp.mail.ru'||process.env.MAIL_HOST,
          port: 465||Number(process.env.MAIL_PORT),
          secure: true,
          auth: {
              user: process.env.MAIL_ADDRESS,
              pass: process.env.MAIL_PASS,
          }
      } 
  })
],
    providers:[EmailService],
    exports:[EmailService]
})
export class EmailModule {}
