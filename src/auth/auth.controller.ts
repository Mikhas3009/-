import { Body, Controller, Get, Post, Req, Res } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UserDto } from './user-dto';
import { Cookie } from './decorators/cookie-parser';
import { PhoneToken } from './decorators/get-phone';
import { Request, Response } from 'express';
import { GetEmail } from './decorators/getEmail';

@Controller('')
export class AuthController {
    constructor(
        private authService: AuthService
    ){}

    @Get('/isLoggedIn')
    async isLoggedIn(@Cookie('accessToken')token){
        try{
            await this.authService.isLoggedIn(token||'eyJhbciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaW8iOiJsYWxhbGFsYSIsImVtYWlsIjoibGFsYWxhbGFsYSIsInBob25lIjoiKzc5MjAwNDE4MDgyIiwicGhvbmVUb2tlbiI6ImFka2FzZHNhZHNhZCIsImFkZHJlc3MiOiJzdWthICIsInJlZ2lvbiI6bnVsbCwiaWF0IjoxNzAwODMxODk4LCJleHAiOjE3MDA5MTgyOTh9.M49XGAG48aoduEfFN7wf-guKB3l_jLbo8BSqEvjpiaU')
            return {
                message:'isLoggined'
            }
        }
        catch(err){
            return err;
        }
    }   

    @Get('/verifyNumber')
    async verifyNumber(@Req() req,@PhoneToken()token:string){
        try{
            const code = await this.authService.vefifyNumber(req,token);
            return code;
        }
        catch(err){
            console.log(err);
            return err;
        }
    }

    @Post('/auth')
    async authUser(@Body()user:UserDto,@Res() res : Response){
        try{
            const token =  await this.authService.authUser(user);
            res.cookie('accessToken', token,{maxAge:1000*60*60*24});
            res.sendStatus(200)
        }
        catch(err){
            res.send(err);
        }
    }

    @Post('/reg')
    async regUser(@Body()user:UserDto,@Res() res:Response){
        try{
           const token = await this.authService.registration(user);
           res.cookie('accessToken', token);
           res.sendStatus(200)
        }   
        catch(err){
            res.send(err);
        }
    }

    @Post('/resetPassword')
    async resetPassword(@Body()body){
        try{
            const email = await this.authService.resetPassword(body.email);
            return{
                message:`Пароль отправлен на почту по адресу: ${email}` 
            };
        }
        catch(err){
            return err;
        }
    }

    @Post('/confirmEmailCode')
    async confirmEmailCode(@Body()body){
        try{
            await this.authService.confirmEmailCode(body);
        }
        catch(err){
            return err;
        }
    }

    @Get('/test')
    async getImage(){
        return await this.authService.getImage();
    }

    @Post('/checkNumber')
    async checkNumber(@Body()body){
        try{
            return await this.authService.checkNumber(body);
        }
        catch(err){
            return err;
        }
    }
}