import { Module } from '@nestjs/common';

import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { GrayModule } from './gray/gray.module';
import { CommentModule } from './comment/comment.module';
import { PrismaService } from './prisma/prisma.service';

@Module({
  imports: [PrismaModule, AuthModule, UserModule, GrayModule, CommentModule],
  providers: [],
})
export class AppModule {}
