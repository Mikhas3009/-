import { Test, TestingModule } from '@nestjs/testing';
import { PersonalCabinetService } from '../personal-cabinet.service';

describe('PersonalCabinetService', () => {
  let service: PersonalCabinetService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PersonalCabinetService],
    }).compile();

    service = module.get<PersonalCabinetService>(PersonalCabinetService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
