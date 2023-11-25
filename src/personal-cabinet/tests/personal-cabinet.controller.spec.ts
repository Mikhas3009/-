import { Test, TestingModule } from '@nestjs/testing';
import { PersonalCabinetController } from '../personal-cabinet.controller';

describe('PersonalCabinetController', () => {
  let controller: PersonalCabinetController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PersonalCabinetController],
    }).compile();

    controller = module.get<PersonalCabinetController>(PersonalCabinetController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
