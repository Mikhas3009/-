import { Test, TestingModule } from '@nestjs/testing';
import { CitizensRequestController } from '../citizens-request.controller';

describe('CitizensRequestController', () => {
  let controller: CitizensRequestController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CitizensRequestController],
    }).compile();

    controller = module.get<CitizensRequestController>(CitizensRequestController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
