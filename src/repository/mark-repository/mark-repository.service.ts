import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { MarkModel } from './mark-model';

@Injectable()
export class MarkRepositoryService {

    constructor(
        @InjectModel(MarkModel) private markRepository: typeof MarkModel
    ){}

    async createMark(mark){
        return await this.markRepository.create()
            .catch(err=>{
                console.error(err);
                throw err;
            })
    }

    async getMarks(){}

}
