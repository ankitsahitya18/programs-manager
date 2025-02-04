import prisma from './prismaClient';

const xprisma = prisma.$extends({
	query: {},
});

export const Program = xprisma.program;
