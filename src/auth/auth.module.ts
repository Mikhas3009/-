import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { FirebaseIntegrationModule } from 'src/firebase/firebase.module';
import { EmailModule } from 'src/email/email.module';
import { UserRepositoryModule } from 'src/repository/user-repository/user-repository.module';
import { MyJwtModule } from 'src/jwt/jwt.module';


@Module({
    imports:[
        FirebaseIntegrationModule,
        EmailModule,
        UserRepositoryModule,
        MyJwtModule
    ],
    controllers: [AuthController],
    providers: [AuthService]
})
export class AuthModule {}
