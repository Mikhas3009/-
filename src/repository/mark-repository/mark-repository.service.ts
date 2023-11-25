import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { MarkModel } from './mark-model';
import { Op } from 'sequelize';

@Injectable()
export class MarkRepositoryService {

    constructor(
        @InjectModel(MarkModel) private markRepository: typeof MarkModel
    ){}

    async createMark(mark){
        return await this.markRepository.create(
            mark
        )
        .catch(err=>{
                console.error(err);
                throw err;
         })
    }

    async createManyMarks(marks){
        await this.markRepository.bulkCreate(marks)
    }

    async updateMark(mark:MarkModel){
        await this.markRepository.update({
            pictures:mark.pictures
        },
            {
                where:{
                    id: mark.id,
                }
            }
        ).catch((err)=>{throw err})
    }

    async getNotAcceptedMarks(){
        return await this.markRepository.findAll()
            .catch(err=>{
                console.log(err);
                throw err;
            })
    }

    async getClosestMarks(latitude:number,longitude:number){
        const limitLatitude = Number(latitude)+1;
        const marks = await this.markRepository.findAll({
            where:
            {
                latitude:{
                    [Op.between]:[latitude - 2, Number(latitude)+ 2],
                },
                longitude:{
                    [Op.between]:[longitude -2, Number(longitude) + 2]
                }
            }
        })
        .catch(err=>{
            console.log(err);
            throw err;
        })
        return marks
    }

    async deleteMark(id){
        return await this.markRepository.destroy({
            where:{
                id:id
            }
        }).catch(err=>{
            throw err;
        })
    }

}
