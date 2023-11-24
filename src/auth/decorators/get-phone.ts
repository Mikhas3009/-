import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const PhoneToken = createParamDecorator(
    ( ctx: ExecutionContext) => {
        const request = ctx.switchToHttp().getRequest();
        return request.body.phoneToken;
    },
)