import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Request } from 'express';

export const Cookie = createParamDecorator(
    (cookieName: string, ctx: ExecutionContext) => {
        const request = ctx.switchToHttp().getRequest<Request>();
        if (request && request.cookies && request.cookies[cookieName]) {
          return request.cookies[cookieName];
        }
    
        return null;
      },
)