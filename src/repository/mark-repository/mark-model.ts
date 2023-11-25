
import { Model ,Table,Column,DataType, ForeignKey, HasMany} from "sequelize-typescript";



@Table({tableName: "marks", createdAt: false, updatedAt: false })
export class MarkModel extends Model<MarkModel> {

    @Column({type: DataType.INTEGER, primaryKey: true, autoIncrement: true,unique: true})
    id:number;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    topic:string;

    @Column({type: DataType.STRING,unique: false,allowNull: false})
    description:string;

    @Column({type: DataType.STRING,unique: false,allowNull: true})
    pictures:string;

    @Column({type: DataType.FLOAT,unique: false,allowNull: false})
    latitude:number;

    @Column({type: DataType.FLOAT,unique: false,allowNull: false})
    longitude:string;

    @Column({type: DataType.BOOLEAN,unique: false,allowNull: true})
    isChecked:boolean;

}