import { Module } from '@nestjs/common';
import { UserRepositoryService } from './user-repository.service';
import { SequelizeModule } from '@nestjs/sequelize';
import { UserModel } from './user-model';

@Module({
    imports:[
        SequelizeModule.forFeature([
            UserModel
        ])
    ],
    providers: [UserRepositoryService],
    exports:[UserRepositoryService]
})
export class UserRepositoryModule {}
