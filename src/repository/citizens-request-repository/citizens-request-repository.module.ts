import { Module } from '@nestjs/common';
import { CitizensRequestRepositoryService } from './citizens-request-repository.service';
import { SequelizeModule } from '@nestjs/sequelize';
import { SitizensReqModel } from './citizens-request-model';

@Module({
    imports:[
        SequelizeModule.forFeature([
            SitizensReqModel
        ])
    ],
    providers: [CitizensRequestRepositoryService],
    exports:[CitizensRequestRepositoryService]
})
export class CitizensRequestRepositoryModule {}
