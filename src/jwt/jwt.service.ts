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
        const {name,email,phone,phoneToken,address,region,role} = data
        const tokenData = {
            fio:name,
            email:email,
            phone:phone,
            phoneToken:phoneToken,
            address:address,
            region:region,
            role:role
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
