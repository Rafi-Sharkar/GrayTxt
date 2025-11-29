import { Controller } from '@nestjs/common';
import { GrayService } from './gray.service';

@Controller('gray')
export class GrayController {
  constructor(private readonly grayService: GrayService) {}
}
