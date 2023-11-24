
import { Model ,Table,Column,DataType, ForeignKey, HasMany} from "sequelize-typescript";
import Sequelize from "sequelize/types/sequelize";


@Table({tableName: "marks", createdAt: false, updatedAt: false })
export class MarkModel extends Model<MarkModel> {

    @Column({type: DataType.INTEGER, primaryKey: true, autoIncrement: true,unique: true})
    id:number;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    topic:string;

    @Column({type: DataType.STRING,unique: true,allowNull: false})
    description:string;

    @Column({type: DataType.STRING,unique: true,allowNull: false})
    pictures:string;

    @Column({type: DataType.GEOGRAPHY('POINT'),unique: true,allowNull: false})
    coordinates:object;


}