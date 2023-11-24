import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserDto } from 'src/auth/user-dto';
import { UserModel } from 'src/repository/user-repository/user-model';

@Injectable()
export class JWTService {
    constructor(
        private jwtService:JwtService
    ){}
    
    async generateAccessToken(data:UserModel){
        const {fio,email,phone,phoneToken,address,region} = data
        const tokenData = {
            fio:fio,
            email:email,
            phone:phone,
            phoneToken:phoneToken,
            address:address,
            region:region
        }
        return this.jwtService.sign(tokenData,{expiresIn:'1d'});
    }

    async generateRefreshToken(data:UserDto){
        
    }

    async decodeToken(token:string){
        return JSON.parse(JSON.stringify(this.jwtService.decode(token)))
    }

    async veifyToken(token){
        return await this.jwtService.verifyAsync(token)
            .catch(err=>{throw err})
    }

}
