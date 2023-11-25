import { Module } from '@nestjs/common';
import { MapController } from './map.controller';
import { MapService } from './map.service';
import { MarkRepositoryModule } from 'src/repository/mark-repository/mark-repository.module';
import { FirebaseIntegrationModule } from 'src/firebase/firebase.module';
import { MyJwtModule } from 'src/jwt/jwt.module';


@Module({
    imports: [
        MarkRepositoryModule,
        FirebaseIntegrationModule,
        MyJwtModule
    ],
    controllers: [MapController],
    providers: [MapService]
})
export class MapModule {}
