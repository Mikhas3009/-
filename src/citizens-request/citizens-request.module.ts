import { Module } from '@nestjs/common';
import { CitizensRequestController } from './citizens-request.controller';
import { CitizensRequestService } from './citizens-request.service';
import { CitizensRequestRepositoryModule } from 'src/repository/citizens-request-repository/citizens-request-repository.module';
import { MyJwtModule } from 'src/jwt/jwt.module';
import { FirebaseIntegrationModule } from 'src/firebase/firebase.module';

@Module({
    imports:[
        CitizensRequestRepositoryModule,
        MyJwtModule,
        FirebaseIntegrationModule
    ],
    controllers: [CitizensRequestController],
    providers: [CitizensRequestService]
})
export class CitizensRequestModule {}
