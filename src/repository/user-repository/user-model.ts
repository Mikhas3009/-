import { Model ,Table,Column,DataType, ForeignKey, HasMany} from "sequelize-typescript";


@Table({tableName: "users", createdAt: false, updatedAt: false })
export class UserModel extends Model {

    @Column({type: DataType.INTEGER, primaryKey: true, autoIncrement: true,unique: true})
    id:number;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    name:string;
    @Column({type: DataType.STRING,unique: true,allowNull: false})
    email:string;

    @Column({type: DataType.STRING,unique: true,allowNull: false})
    phone:string;

    @Column({type: DataType.STRING,unique: true,allowNull: false})
    phoneToken:string;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    password:string;

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    region:string;  

    
    @Column({type: DataType.STRING,unique: false,allowNull: true})
    role:string; 

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    avatar:string

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    address:string;  
    
    @Column({type: DataType.STRING,unique: false,allowNull: true})
    accessToken:string

    
    @Column({type: DataType.STRING,unique: false,allowNull: true})
    refreshToken:string

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    emailCode:string

}