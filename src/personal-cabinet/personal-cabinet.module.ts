import { Module } from '@nestjs/common';
import { PersonalCabinetController } from './personal-cabinet.controller';
import { PersonalCabinetService } from './personal-cabinet.service';
import { MyJwtModule } from 'src/jwt/jwt.module';
import { UserRepositoryModule } from 'src/repository/user-repository/user-repository.module';
import { FirebaseIntegrationModule } from 'src/firebase/firebase.module';

@Module({
    imports:[
        MyJwtModule,
        UserRepositoryModule,
        FirebaseIntegrationModule
    ],
    controllers: [PersonalCabinetController],
    providers: [PersonalCabinetService]
})
export class PersonalCabinetModule {}
