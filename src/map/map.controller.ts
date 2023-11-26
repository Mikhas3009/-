import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { MapService } from './map.service';
import { FilesInterceptor } from '@nestjs/platform-express';
import { RolesGuard } from 'src/roles-guards/admin-guard';
import { UserRoles } from 'src/roles-guards/roles';
import { Roles } from 'src/roles-guards/role-decorator';
import { GlobalResponse } from 'src/globals/global-response-type';

@Controller('map')
export class MapController {

    constructor(private mapService:MapService){}

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @UseInterceptors(FilesInterceptor('files'))
    @Post('/addMark')
    async addMark(@Body()mark,@UploadedFiles()files){
        try{
            await this.mapService.addMark(mark,files)
            return new GlobalResponse(200,true,"Отметка успешно добавлена").response
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }   

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @UseInterceptors(FilesInterceptor('files'))
    @Post('/updateMark')
    async updateMark(@Body()mark,@UploadedFiles()files){
        try{
            await this.mapService.updateMark(mark,files)
            return new GlobalResponse(200,true,"Отметка успешно изменена").response
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }   


    @Get('/getClosestMarks')
    async getClosestMark(@Body()coordinates){
        try{
            const marks =  await this.mapService.getClosestMarks(coordinates);
            return new GlobalResponse(200,true,"Отметки успешно получены",'',marks).response
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }

    @Get('/getMarks')
    async getMarks(){
        try{
            const marks = await this.mapService.getAllMarks();
            return new GlobalResponse(200,true,"Отметки успешно получены",'',marks).response
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }

    @Get('/mark/:id')
    async getMarkById(@Param('id',ParseIntPipe)id){
        try{
            const mark = await this.mapService.getMarkById(id)
            return new GlobalResponse(200,true,"Отметка успешно получена",'',mark).response
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin)
    @Get('/unConfirmedMarks')
    async getUnConfirmedMarks(){
        try{
            const marks =  await this.mapService.getUnConfirmedMarks();
            return new GlobalResponse(200,true,"Отметка успешно получена",'',marks).response
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @Delete('/deleteMark')
    async deleteMark(@Body()mark){
        try{
            await this.mapService.deleteMark(mark);
            return (new GlobalResponse(200,true,"Отметка успешно удалена").response)
        }
        catch(err){
            return new GlobalResponse(400,false,err.message).response
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin)
    @Put('/confrimMark')
    async confirmMark(@Body()mark){
        try{
            await this.mapService.confirmMark(mark)
            return (new GlobalResponse(200,true,"Отметка успешно подтверждена").response)
        }
        catch(err){
            return (new GlobalResponse(400,false,err.message))
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @Post('/addMarks')
    async addMarks(@Body()marks){
        console.log(marks)
        try{
            await this.mapService.addMarks(marks)
            return (new GlobalResponse(200,true,"Отметка успешно добавлена").response)
        }
        catch(err){
            return (new GlobalResponse(400,false,err.message))
        }
    }  
}
