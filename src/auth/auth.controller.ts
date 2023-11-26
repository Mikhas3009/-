import { Body, Controller, Get, Post, Req, Res, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UserDto } from './user-dto';
import { Cookie } from './decorators/cookie-parser';
import { PhoneToken } from './decorators/get-phone';
import { Request, Response } from 'express';
import { GetEmail } from './decorators/getEmail';
import { RolesGuard } from 'src/roles-guards/admin-guard';
import { Roles } from 'src/roles-guards/role-decorator';
import { UserRoles } from 'src/roles-guards/roles';
import { GlobalResponse } from 'src/globals/global-response-type';

@Controller('')
export class AuthController {
    constructor(
        private authService: AuthService
    ) { }

    @Get('/isLoggedIn')
    async isLoggedIn(@Cookie('accessToken') token) {
        try {
            await this.authService.isLoggedIn(token);
            return new GlobalResponse(200,true,"IsLoggedIn").response;
        }
        catch (err) {
            return new GlobalResponse(400,false,"isNotLoggedIn").response;
        }
    }

    @Post('/checkEmail')
    async checkEmail(@Body() body) {
        try {
            const success = await this.authService.checkEmail(body);
            return (new GlobalResponse(success ? 200 : 401,success,success ? "Успешно" : "Данная почта уже используется").response)
        }
        catch (err) {
            return (new GlobalResponse(401,false,err.message)).response;
        }
    }
    @Post('/verifyNumber')
    async verifyNumber(@Body() body) {
        try {
            const code = await this.authService.vefifyNumber(body, body.phoneToken);
            return (new GlobalResponse(200,true,"Успешно",code.code).response)
        }
        catch (err) {
            return (new GlobalResponse(401,false,err.message).response)
        }
    }

    @Post('/auth')
    async authUser(@Body() user: UserDto, @Res() res: Response) {
        try {
            console.log(user)
            const token = await this.authService.authUser(user);
            res.cookie('accessToken', token, { maxAge: 1000 * 60 * 60 * 24, secure: true, sameSite: 'none' });
            res.send( new GlobalResponse(200,true,"Авторизациия прошла успешно").response)
        }
        catch (err) {
            console.log(err)
            res.send(new GlobalResponse(401,false,err.message).response);
        }
    }

    @Post('/reg')
    async regUser(@Body() user: UserDto, @Res() res: Response) {
        try {
            const token = await this.authService.registration(user);
            res.cookie('accessToken', token,{maxAge: 1000 * 60 * 60 * 24,secure:true});
            res.send(new GlobalResponse(200,true,"Регистрация прошла успешна").response)
        }
        catch (err) {
            res.send(new GlobalResponse(401,false,err.message).response);
        }
    }

    @UseGuards(RolesGuard)
    @Roles(UserRoles.Admin)
    @Post('/regService')
    async regService(@Body() user: UserDto, @Res() res: Response) {
        try {
            const token = await this.authService.registration(user, UserRoles.Service);
            res.cookie('accessToken', token,{secure:true,maxAge: 1000 * 60 * 60 * 24});
            res.send(new GlobalResponse(200,true,'Упешно').response);
        }
        catch (err) {
            res.send(new GlobalResponse(401,false,err.message).response);
        }
    }

    @Post('/restorePassword')
    async resetPassword(@Body() body) {
        try {
            const email = await this.authService.restorePassword(body.phone);
            return (new GlobalResponse(200,true,'Упешно').response);
        }
        catch (err) {
            return (new GlobalResponse(401,false,err.message).response);;
        }
    }

    @Post('/confirmEmailCode')
    async confirmEmailCode(@Body() body) {
        try {
            await this.authService.confirmEmailCode(body);
        }
        catch (err) {
            return err;
        }
    }

    @Get('/test')
    async getImage() {
        return await this.authService.getImage();
    }

    @Post('/checkPhone')
    async checkNumber(@Body() body) {
        try {
            const success = await this.authService.checkNumber(body);
            return (new GlobalResponse(success ? 200 : 401,success,success ? "Успешно" : "Данный номер уже используется").response)
        }
        catch (err) {
            return (new GlobalResponse(401,false,err.message)).response;
        }
    }
}