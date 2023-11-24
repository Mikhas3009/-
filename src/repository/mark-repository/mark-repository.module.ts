import { Module } from '@nestjs/common';
import { MarkRepositoryService } from './mark-repository.service';
import { SequelizeModule } from '@nestjs/sequelize';
import { MarkModel } from './mark-model';

@Module({
    imports:[
        SequelizeModule.forFeature([
            MarkModel
        ])
    ],
    providers: [MarkRepositoryService],
    exports:[MarkRepositoryService]
})
export class MarkRepositoryModule {}
