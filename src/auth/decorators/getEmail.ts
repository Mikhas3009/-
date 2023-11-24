import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const GetEmail = createParamDecorator(
    ( ctx: ExecutionContext) => {
        console.log(ctx)
        const request = ctx.switchToHttp().getRequest();
        return request.body.email;
    },
)