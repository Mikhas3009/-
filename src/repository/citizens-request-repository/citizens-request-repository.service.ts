import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { SitizensReqModel } from './citizens-request-model';

@Injectable()
export class CitizensRequestRepositoryService {

    constructor(
        @InjectModel(SitizensReqModel) private citizensReqRep: typeof SitizensReqModel
    ) { }

    async addRequest(req: SitizensReqModel) {
        return await this.citizensReqRep.create(req)
            .catch((err) => {
                throw err;
            })
    }

    async getRequestById(id: number) {
        return await this.citizensReqRep.findOne({
            where: {
                id: id
            }
        })
            .catch((err) => {
                throw err;
            })
    }

    async getReqByServiceId(idService:number){
        return await this.citizensReqRep.findAll({
            where: {
                serviceId: String(idService)
            }
        })
            .catch((err) => {
                throw err;
            })
    }

    async getReqByUserId(idUser){
        return await this.citizensReqRep.findAll({
            where: {
                userId: String(idUser)
            }
        })
            .catch((err) => {
                throw err;
            })
    }

    async updateRequest(request:SitizensReqModel){
        await this.citizensReqRep.update({
            topic: request.topic,
            description: request.description,
            latitude: request.latitude,
            longitude: request.longitude,
            category: request.category,
            pictures:request.pictures,
        },
            {
                where:{
                    id: request.id,
                }
            }
        ).catch((err)=>{throw err})
    }

    async confirmRequest(id){
        await this.citizensReqRep.update({
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

    async getUnConfirmedReq(){
        return await this.citizensReqRep.findAll({
            where:{
                isChecked:false
            }
        }).catch((err)=>{throw err})
    }
}
