import { Module } from '@nestjs/common';
import { JWTService } from './jwt.service';
import { JwtModule } from '@nestjs/jwt';

@Module({
    imports:[
        JwtModule.register({
            global: true,
            secret: "lalala",
            signOptions: { expiresIn: '60s' },
        })
    ],
    providers:[JWTService],
    exports:[JWTService]
})
export class MyJwtModule {}
