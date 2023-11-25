import { Test, TestingModule } from '@nestjs/testing';
import { CitizensRequestRepositoryService } from '../citizens-request-repository.service';

describe('CitizensRequestRepositoryService', () => {
  let service: CitizensRequestRepositoryService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CitizensRequestRepositoryService],
    }).compile();

    service = module.get<CitizensRequestRepositoryService>(CitizensRequestRepositoryService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
