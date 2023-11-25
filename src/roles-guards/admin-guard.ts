import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';
import { UserRoles } from './roles';
import { JWTService } from 'src/jwt/jwt.service';

@Injectable()
export class RolesGuard implements CanActivate {
    constructor(private reflector: Reflector, private jwtService: JWTService) { }

    async canActivate(context: ExecutionContext): Promise<boolean> {
        const roles = this.reflector.get<UserRoles[]>('roles', context.getHandler());
        if (!roles) {
            return false;
        }
        const request = context.switchToHttp().getRequest();
        const accessToken = request.cookies['accessToken'];

        if (!accessToken) {
            // Если токен отсутствует, блокируем доступ
            return false;
        }

        try {
            const decodedToken = await this.jwtService.veifyToken(accessToken);
            const userRole = decodedToken.role;
            return roles == userRole;
        }
        catch (error) {
            // Если токен недействителен, блокируем доступ
            return false;
        }
    }
}
