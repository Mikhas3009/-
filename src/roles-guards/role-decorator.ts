import { SetMetadata } from '@nestjs/common';
import { UserRoles } from './roles';


export const Roles = (...roles: UserRoles[]) => SetMetadata('roles', roles);