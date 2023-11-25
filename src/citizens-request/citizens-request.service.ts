import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { FirebaseService } from 'src/firebase/firebase.service';
import { JWTService } from 'src/jwt/jwt.service';
import { SitizensReqModel } from 'src/repository/citizens-request-repository/citizens-request-model';
import { CitizensRequestRepositoryService } from 'src/repository/citizens-request-repository/citizens-request-repository.service';
import { UserRoles } from 'src/roles-guards/roles';

@Injectable()
export class CitizensRequestService {

    constructor(
        private sitizensReqRep:CitizensRequestRepositoryService,
        private jwtService:JWTService,
        private firebaseService:FirebaseService
    ){}

    async addRequest(req:SitizensReqModel,token:string,files){
        const {id} = await this.jwtService.decodeToken(token)
        req.isChecked = false;
        req.userId = id;
        const request = await this.sitizensReqRep.addRequest(req)
            .catch((err)=>{
                console.log(err);
                throw new HttpException('Не удалось добавить обращение',HttpStatus.BAD_GATEWAY);
            })
        let path = '';
        files.forEach((file)=>{
            path = path+file.originalname+" "
        })
        path = path.slice(0,path.length-1)
        request.pictures = path;
        const [res1 ,res2 ] = await Promise.all([
            this.firebaseService.uploadFilesToUserFolder(String(request.id),files,'request'),
            this.sitizensReqRep.updateRequest(request)
        ]).catch((err)=>{
                throw err;
        })
    }

    async getMyRequest(token:string){
        const {id,role} = await this.jwtService.decodeToken(token);
        let requests:SitizensReqModel[] = [];
        console.log(role==UserRoles.User,id)
        if(role == UserRoles.User ){
            requests = await this.sitizensReqRep.getReqByUserId(id)
                .catch((err)=>{
                    console.log(err);
                    throw new HttpException('Не получить ваши обращения',HttpStatus.BAD_GATEWAY);
                });
        }
        if(role == UserRoles.Service){
            requests = await this.sitizensReqRep.getReqByServiceId(id)
            .catch((err)=>{
                console.log(err);
                throw new HttpException('Не получить ваши обращения',HttpStatus.BAD_GATEWAY);
            }); 
        }
        await Promise.all(requests.map(async (req) => {
            const pictures = req.pictures.split(' ');
            req.pictures = '';
    
            await Promise.all(pictures.map(async (picture) => {
                const url = await this.firebaseService.getPhotoUrl(String(req.id), picture,'service');
                req.pictures = req.pictures + url+" ";
            }));
        }));

        return requests;

    }

    async confirmRequest(req){
        const{id}=req
        await this.sitizensReqRep.confirmRequest(id)
            .catch((err)=>{
                console.log(err);
                throw err;
            });
    }
}
