import { Body, Controller, Get, Put, Req, Res, UploadedFile, UseInterceptors } from '@nestjs/common';
import { Cookie } from 'src/auth/decorators/cookie-parser';
import { PersonalCabinetService } from './personal-cabinet.service';
import { Request, Response } from 'express';
import { UserDto } from 'src/auth/user-dto';
import { FileInterceptor } from '@nestjs/platform-express';

@Controller('')
export class PersonalCabinetController {

    constructor(
        private personalCabinetService:PersonalCabinetService
    ){}

    @Get('/personalData')
    async getPersonalCabinet(@Cookie('accessToken')token){
        try{
            console.log(token)
            return await this.personalCabinetService.getPersonalData(token)
        }
        catch(err){
            return err;
        }
    }

    @Put('/updatePersonalData')
    @UseInterceptors(FileInterceptor('file'))
    async updatePersonalCabinet(@Body()user:UserDto,@UploadedFile()file){
        try{
            return await this.personalCabinetService.updatePersonalData(user,file)
        }
        catch(err){
            return err;
        }
    }

    @Get('/logOut')
    async exit(@Res()res:Response){
        res.clearCookie('accessToken')
        res.sendStatus(200)
    }
}
