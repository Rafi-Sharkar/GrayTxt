-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('ON', 'OFF');

-- CreateEnum
CREATE TYPE "Themes" AS ENUM ('DARK', 'LIGHT');

-- CreateEnum
CREATE TYPE "Languages" AS ENUM ('ENGLISH', 'BANGLA', 'HINDI');

-- CreateEnum
CREATE TYPE "Countries" AS ENUM ('BANGLADESH', 'INDIA', 'PAKISTAN', 'NEPAL', 'SRILANKA');

-- CreateTable
CREATE TABLE "Users" (
    "id" TEXT NOT NULL,
    "userName" VARCHAR(45) NOT NULL,
    "fullName" VARCHAR(45) NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userSince" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastLogin" TIMESTAMP(3),
    "active" BOOLEAN,
    "profilePicture" TEXT,
    "userUpdatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserProfiles" (
    "userId" TEXT NOT NULL,
    "description" VARCHAR(600),
    "state" TEXT,
    "country" "Countries",
    "website" TEXT[],
    "birthDate" TIMESTAMP(3),

    CONSTRAINT "UserProfiles_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "UserSettings" (
    "userId" TEXT NOT NULL,
    "theme" "Themes" NOT NULL DEFAULT 'LIGHT',
    "language" "Languages" NOT NULL DEFAULT 'ENGLISH',
    "country" "Countries",

    CONSTRAINT "UserSettings_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "UserNotifications" (
    "userId" TEXT NOT NULL,
    "emailNotifications" "NotificationStatus" NOT NULL,
    "pushNotifications" "NotificationStatus" NOT NULL,
    "notificationMessages" "NotificationStatus" NOT NULL,

    CONSTRAINT "UserNotifications_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Grays" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "grayTxt" VARCHAR(511) NOT NULL,
    "grayPhoto" TEXT,
    "grayVideo" TEXT,
    "inReplyToGrayId" VARCHAR(511),
    "inReplyToUserId" VARCHAR(511),
    "retweetCount" INTEGER NOT NULL DEFAULT 0,
    "favoriteCount" INTEGER NOT NULL DEFAULT 0,
    "language" "Languages",
    "country" "Countries",
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Grays_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favorites" (
    "userId" TEXT NOT NULL,
    "grayId" TEXT NOT NULL,
    "favoritedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Favorites_pkey" PRIMARY KEY ("userId","grayId")
);

-- CreateTable
CREATE TABLE "GrayLikes" (
    "userId" TEXT NOT NULL,
    "grayId" TEXT NOT NULL,
    "likeSent" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GrayLikes_pkey" PRIMARY KEY ("userId","grayId")
);

-- CreateTable
CREATE TABLE "GrayViews" (
    "userId" TEXT NOT NULL,
    "grayId" TEXT NOT NULL,
    "viewCount" INTEGER NOT NULL,

    CONSTRAINT "GrayViews_pkey" PRIMARY KEY ("userId","grayId")
);

-- CreateTable
CREATE TABLE "GrayComments" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "grayId" TEXT NOT NULL,
    "comment" VARCHAR(255),
    "commentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "parentId" TEXT,

    CONSTRAINT "GrayComments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserFollows" (
    "followerId" TEXT NOT NULL,
    "followingId" TEXT NOT NULL,
    "followedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserFollows_pkey" PRIMARY KEY ("followerId","followingId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- AddForeignKey
ALTER TABLE "UserProfiles" ADD CONSTRAINT "UserProfiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSettings" ADD CONSTRAINT "UserSettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserNotifications" ADD CONSTRAINT "UserNotifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Grays" ADD CONSTRAINT "Grays_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_grayId_fkey" FOREIGN KEY ("grayId") REFERENCES "Grays"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayLikes" ADD CONSTRAINT "GrayLikes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayLikes" ADD CONSTRAINT "GrayLikes_grayId_fkey" FOREIGN KEY ("grayId") REFERENCES "Grays"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayViews" ADD CONSTRAINT "GrayViews_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayViews" ADD CONSTRAINT "GrayViews_grayId_fkey" FOREIGN KEY ("grayId") REFERENCES "Grays"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayComments" ADD CONSTRAINT "GrayComments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayComments" ADD CONSTRAINT "GrayComments_grayId_fkey" FOREIGN KEY ("grayId") REFERENCES "Grays"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrayComments" ADD CONSTRAINT "GrayComments_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "GrayComments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFollows" ADD CONSTRAINT "UserFollows_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFollows" ADD CONSTRAINT "UserFollows_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
