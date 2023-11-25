export class GlobalResponse{
    response:{
        statusCode:number,
        message?:string,
        success:boolean
        code?:string
    }
    constructor(statusCode:number,success:boolean,message?:string,code?:string){
        this.response = {statusCode,success,message,code}
    }
}