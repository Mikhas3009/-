import { MailerService } from '@nestjs-modules/mailer';
import { Injectable } from '@nestjs/common';
import { UserModel } from 'src/repository/user-repository/user-model';

@Injectable()
export class EmailService {
    
    constructor(
        private readonly mailService:MailerService)
    {};

    async sendMail(user:UserModel,emailAddress?:string) {//отправка письма
        await this.mailService.sendMail({
            to: emailAddress?emailAddress:"prusakov_tr@mail.ru",
            from: `ske3y@mail.ru`||process.env.SERVER_EMAIL,
            subject: `Восстановление пароля Навигатор Чистоты`,
            //text: `Тема сообщения: ${req.subject}\nОт кого: ${req.email}, ${req.name}\nСообщение: ${req.message}`
            text: `
            Уважаемый(ая) ${user.fio},
            
            Вы или кто-то другой запросили восстановление пароля для вашего аккаунта на сервисе: "Навигатор Чистоты". Мы готовы помочь вам в этом процессе.
            
            Ваш номер аккаунта: ${user.phone}
            
            Ваш пароль: ${user.password}
            
            Если вы не запрашивали сброс пароля, пожалуйста, проигнорируйте это сообщение. Ваш аккаунт останется в безопасности.
            
            С уважением, команда сервиса: "Навигатор Чистоты"`
         }).catch((err)=>{throw err})
        return user.password
    }
}
