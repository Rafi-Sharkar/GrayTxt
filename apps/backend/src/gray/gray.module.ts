import { Module } from '@nestjs/common';
import { GrayService } from './gray.service';
import { GrayController } from './gray.controller';

@Module({
  controllers: [GrayController],
  providers: [GrayService],
})
export class GrayModule {}
