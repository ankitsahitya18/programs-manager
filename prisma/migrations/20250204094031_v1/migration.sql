-- CreateEnum
CREATE TYPE "ProgramStatus" AS ENUM ('Draft', 'Live');

-- CreateEnum
CREATE TYPE "AppleLogoSize" AS ENUM ('square', 'rectangle');

-- CreateTable
CREATE TABLE "Program" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "status" "ProgramStatus" NOT NULL DEFAULT 'Draft',
    "webhookId" VARCHAR(255),
    "pointsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "pointsExpire" BOOLEAN NOT NULL DEFAULT true,
    "expirationPeriod" INTEGER NOT NULL DEFAULT 12,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "Program_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProgramLocale" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,
    "programId" INTEGER NOT NULL,

    CONSTRAINT "ProgramLocale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProgramMarketing" (
    "id" SERIAL NOT NULL,
    "reward" VARCHAR(5000) NOT NULL,
    "status" "ProgramStatus" NOT NULL DEFAULT 'Live',
    "position" INTEGER,
    "programId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "ProgramMarketing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProgramMarketingTier" (
    "id" SERIAL NOT NULL,
    "programMarketingId" INTEGER NOT NULL,
    "tierId" BIGINT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProgramMarketingTier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProgramMarketingLocale" (
    "id" SERIAL NOT NULL,
    "programMarketingId" INTEGER NOT NULL,
    "reward" VARCHAR(5000) NOT NULL,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "ProgramMarketingLocale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tier" (
    "id" BIGSERIAL NOT NULL,
    "programId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "index" INTEGER NOT NULL,
    "passColors" JSONB,
    "tierBenefits" VARCHAR(255),
    "description" VARCHAR(255),
    "information" VARCHAR(255),
    "informationFieldLockscreenMessage" VARCHAR(255),
    "iconImageUrl" VARCHAR(750),
    "logoImageUrl" VARCHAR(750),
    "appleLogoImageUrl" VARCHAR(750),
    "stripImageUrl" VARCHAR(750),
    "heroImageUrl" VARCHAR(750),
    "samplePassUrl" VARCHAR(750),
    "companyName" VARCHAR(750),
    "programName" VARCHAR(750),
    "appleLogoSize" "AppleLogoSize" NOT NULL DEFAULT 'square',
    "localeData" JSONB,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,
    "expiryDate" TIMESTAMP(3),
    "pointThreshold" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Tier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TierBenefits" (
    "id" BIGSERIAL NOT NULL,
    "tierId" BIGINT NOT NULL,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "TierBenefits_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TierLocale" (
    "id" BIGSERIAL NOT NULL,
    "tierId" BIGINT NOT NULL,
    "localeId" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "tierBenefits" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "information" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "TierLocale_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ProgramLocale_name_key" ON "ProgramLocale"("name");

-- CreateIndex
CREATE INDEX "ProgramLocale_programId_idx" ON "ProgramLocale"("programId");

-- CreateIndex
CREATE INDEX "ProgramMarketing_programId_idx" ON "ProgramMarketing"("programId");

-- CreateIndex
CREATE INDEX "ProgramMarketingLocale_programMarketingId_idx" ON "ProgramMarketingLocale"("programMarketingId");

-- CreateIndex
CREATE INDEX "Tier_programId_idx" ON "Tier"("programId");

-- CreateIndex
CREATE UNIQUE INDEX "Tier_name_programId_key" ON "Tier"("name", "programId");

-- CreateIndex
CREATE UNIQUE INDEX "TierLocale_name_key" ON "TierLocale"("name");

-- CreateIndex
CREATE INDEX "TierLocale_tierId_idx" ON "TierLocale"("tierId");

-- CreateIndex
CREATE UNIQUE INDEX "TierLocale_tierId_localeId_key" ON "TierLocale"("tierId", "localeId");

-- AddForeignKey
ALTER TABLE "ProgramLocale" ADD CONSTRAINT "ProgramLocale_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProgramMarketing" ADD CONSTRAINT "ProgramMarketing_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProgramMarketingTier" ADD CONSTRAINT "ProgramMarketingTier_programMarketingId_fkey" FOREIGN KEY ("programMarketingId") REFERENCES "ProgramMarketing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProgramMarketingTier" ADD CONSTRAINT "ProgramMarketingTier_tierId_fkey" FOREIGN KEY ("tierId") REFERENCES "Tier"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProgramMarketingLocale" ADD CONSTRAINT "ProgramMarketingLocale_programMarketingId_fkey" FOREIGN KEY ("programMarketingId") REFERENCES "ProgramMarketing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tier" ADD CONSTRAINT "Tier_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TierBenefits" ADD CONSTRAINT "TierBenefits_tierId_fkey" FOREIGN KEY ("tierId") REFERENCES "Tier"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TierLocale" ADD CONSTRAINT "TierLocale_tierId_fkey" FOREIGN KEY ("tierId") REFERENCES "Tier"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
