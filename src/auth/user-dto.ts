export interface UserDto{
    fio:string;
    phone: string;
    address: string;
    confrimPassword?:string;
    email?: string;
    password: string;
    phoneToken:string
}