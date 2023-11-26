
import { Model ,Table,Column,DataType, ForeignKey, HasMany, HasOne, BelongsTo} from "sequelize-typescript";
import { UserModel } from "../user-repository/user-model";
import { DataTypes } from "sequelize";



@Table({tableName: "citizens-request", createdAt: false, updatedAt: false })
export class SitizensReqModel extends Model<SitizensReqModel> {

    @Column({type: DataType.INTEGER, primaryKey: true, autoIncrement: true,unique: true})
    id:number;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    topic:string;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    description:string;

    @Column({type: DataType.ARRAY(DataTypes.STRING),unique: false,allowNull: true})
    pictures:string[];

    @Column({type: DataType.FLOAT,unique: false,allowNull: true})
    latitude:number;

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    category:string;

    @Column({type: DataType.FLOAT,unique: false,allowNull: true})
    longitude:string;

    @Column({type: DataType.BOOLEAN,unique: false,allowNull: true})
    isChecked:boolean;
    
    @Column({type: DataType.DATE,unique: false,allowNull: true})
    publicationDate:Date;

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    response:string;

    @Column({type:DataType.STRING,unique: false,allowNull: false})
    serviceId:string;

    @ForeignKey(()=>UserModel)
    @Column({type: DataType.INTEGER})
    userId:number;
    @BelongsTo(() => UserModel)
    user: UserModel;

}