import { Test, TestingModule } from '@nestjs/testing';
import { MarkRepositoryService } from '../mark-repository.service';

describe('MarkRepositoryService', () => {
  let service: MarkRepositoryService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [MarkRepositoryService],
    }).compile();

    service = module.get<MarkRepositoryService>(MarkRepositoryService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
