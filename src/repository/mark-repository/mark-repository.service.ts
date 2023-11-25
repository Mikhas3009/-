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
            topic: mark.topic,
            description: mark.description,
            latitude: mark.latitude,
            longitude: mark.longitude,
            category: mark.category,
            pictures:mark.pictures,
        },
            {
                where:{
                    id: mark.id,
                }
            }
        ).catch((err)=>{throw err})
    }

    async confirmMark(id){
        await this.markRepository.update({
            isChecked:true,
            publicationDate:new Date()
        },
            {
                where:{
                    id: id,
                }
            }
        ).catch((err)=>{throw err})
    }

    async getNotAcceptedMarks(){
        return await this.markRepository.findAll({
            where:{
                isChecked:false
            }
        })
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
                },
                isChecked:true
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
    
    async getMarkById(id:number){
        return await this.markRepository.findOne({
            where:{
                id:id
            }
        }).catch(err=>{
            throw err;
        })
    }

    async getAllMarks(){
        return await this.markRepository.findAll()
        .catch(err=>{
            throw err;
        })
    }

}
