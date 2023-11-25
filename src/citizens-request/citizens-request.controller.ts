import { Body, Controller, Get, Post, Put, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { Cookie } from 'src/auth/decorators/cookie-parser';
import { CitizensRequestService } from './citizens-request.service';
import { GlobalResponse } from 'src/globals/global-response-type';
import { FilesInterceptor } from '@nestjs/platform-express';
import { RolesGuard } from 'src/roles-guards/admin-guard';
import { UserRoles } from 'src/roles-guards/roles';
import { Roles } from 'src/roles-guards/role-decorator';

@Controller('citizens-request')
export class CitizensRequestController {

    constructor (
        private citizensReqService:CitizensRequestService
        ){}

    @UseInterceptors(FilesInterceptor('files'))    
    @Post('/addRequest')
    async addRequest(@Body()req,@Cookie('accessToken')token,@UploadedFiles()files){
        try{
            await this.citizensReqService.addRequest(req,token,files);
            return (new GlobalResponse(200,true,"Обращение успешно создано"));
        }
        catch(err){
            return (new GlobalResponse(401,false,err.message));
        }
    }

    @Get('/getMyRequest')
    async getMyRequest(@Body()req,@Cookie('accessToken')token){
        try{
            return await this.citizensReqService.getMyRequest(token)
        }
        catch(err){
            return err;
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin)
    @Put('/confirmedRequest')
    async getUnConfirmedMarks(@Body()req){
        try{
            return await this.citizensReqService.confirmRequest(req);
        }
        catch(err){
            return err;
        }
    }
}
