import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UserDto } from 'src/auth/user-dto';
import { FirebaseService } from 'src/firebase/firebase.service';
import { JWTService } from 'src/jwt/jwt.service';
import { UserRepositoryService } from 'src/repository/user-repository/user-repository.service';

@Injectable()
export class PersonalCabinetService {

    constructor (
        private jwtService: JWTService,
        private userRepository: UserRepositoryService,
        private firebaseService:FirebaseService
    ){}

    async getPersonalData(token: string){
        const{email} = await this.jwtService.decodeToken(token);
        const user = await this.userRepository.findByEmail(email)
            .catch((err)=>{
                throw new UnauthorizedException("Пользователь не существует");
            })
        if(user.avatar){
            user.avatar = await this.firebaseService.getPhotoUrl(String(user.id),user.avatar,'user')
        }
        else{
            user.avatar = '';
        }
        return user;
    }

    async updatePersonalData(user:UserDto,file){
        const{email,phone,name,avatar,address} = user;
        console.log(user,file)
        const [updatedUser] = await this.userRepository.updateUserData(name,email,address,file.originalname)
            .catch(err=>{
                console.log(err);
                throw err;
            });
        await this.firebaseService.uploadFilesToUserFolder(String(updatedUser.id),[file],'user')
            .catch(err=>{
                console.log(err);
                throw err;
            });
        return 'Success';
    }
}
