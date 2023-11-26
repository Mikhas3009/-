export class GlobalResponse{
    response:{
        statusCode:number,
        message?:string,
        success:boolean
        code?:string
        data?:any
    }
    constructor(statusCode:number,success:boolean,message?:string,code?:string,data?:any) {
        this.response = {statusCode,success,message,code,data:data}
    }
}