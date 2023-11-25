import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { MapService } from './map.service';
import { FilesInterceptor } from '@nestjs/platform-express';
import { RolesGuard } from 'src/roles-guards/admin-guard';
import { UserRoles } from 'src/roles-guards/roles';
import { Roles } from 'src/roles-guards/role-decorator';

@Controller('map')
export class MapController {

    constructor(private mapService:MapService){}

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @UseInterceptors(FilesInterceptor('files'))
    @Post('/addMark')
    async addMark(@Body()mark,@UploadedFiles()files){
        try{
            return await this.mapService.addMark(mark,files)
        }
        catch(err){
            return err;
        }
    }   

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @UseInterceptors(FilesInterceptor('files'))
    @Post('/updateMark')
    async updateMark(@Body()mark,@UploadedFiles()files){
        try{
            return await this.mapService.updateMark(mark,files)
        }
        catch(err){
            return err;
        }
    }   


    @Get('/getClosestMarks')
    async getClosestMark(@Body()coordinates){
        try{
            return await this.mapService.getClosestMarks(coordinates);
        }
        catch(err){
            return err;
        }
    }

    @Get('/getMarks')
    async getMarks(){
        try{
            return await this.mapService.getAllMarks();
        }
        catch(err){
            return err;
        }
    }

    @Get('/mark/:id')
    async getMarkById(@Param('id',ParseIntPipe)id){
        try{
            return await this.mapService.getMarkById(id)
        }
        catch(err){
            return err;
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin)
    @Get('/unConfirmedMarks')
    async getUnConfirmedMarks(){
        try{
            return await this.mapService.getUnConfirmedMarks();
        }
        catch(err){
            return err;
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @Delete('/deleteMark')
    async deleteMark(@Body()mark){
        try{
            return await this.mapService.deleteMark(mark);
        }
        catch(err){
            return err;
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin)
    @Put('/confrimMark')
    async confirmMark(@Body()mark){
        try{
            await this.mapService.confirmMark(mark)
        }
        catch(err){
            return err;
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin,UserRoles.Service)
    @Post('/addMarks')
    async addMarks(@Body()marks){
        console.log(marks)
        try{
            await this.mapService.addMarks(marks)
        }
        catch(err){
            return err;
        }
    }  
}
