import { Test, TestingModule } from '@nestjs/testing';
import { CitizensRequestService } from '../citizens-request.service';

describe('CitizensRequestService', () => {
  let service: CitizensRequestService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CitizensRequestService],
    }).compile();

    service = module.get<CitizensRequestService>(CitizensRequestService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
