import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { UserModel } from './user-model';

@Injectable()
export class UserRepositoryService {

    constructor(
        @InjectModel(UserModel) private userRepository: typeof UserModel
    ) { }

    async findByNumber(number: string) {
        return await this.userRepository.findOne({
            where: {
                phone: number
            }
        }).catch(err => {
            console.log(err);
            throw err;
        });
    }

    async createUser(user) {
        return await this.userRepository.create(user).
            catch(err => {
                console.error(err);
                throw err;
            })
    }

    async findByEmail(email: string) {
        return await this.userRepository.findOne({
            where: {
                email: email
            }
        }).catch(err => {
            console.log(err);
            throw err;
        });
    }

    async setEmailCode(phone: string, code: string) {
        const [rows, user] = await this.userRepository.update(
            {
                emailCode: code
            },
            {
                where: {
                    phone: phone
                },
                returning: true,
            }
        ).catch(err => {
            throw err;
        })
        if (!user) {
            throw new Error('Аккаунта не существует')
        }
        return user[0]
    }

    async updatePassword(email: string, password: string) {
        await this.userRepository.update(
            {
                password: password
            },
            {
                where: {
                    email: email
                }
            }
        ).catch(err => {
            throw err;
        })
    }

    async updateUserData(name, email, address, avatar) {
       const [rows,user] = await this.userRepository.update(
            {
                name: name,
                email: email,
                address: address,
                avatar: avatar
            },
            {
                where:{
                    email: email
                },
                returning: true,
       }).catch(err=>{
            throw err;
       })
       return user
    }
}
