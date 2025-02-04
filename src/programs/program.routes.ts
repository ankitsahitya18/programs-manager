import { ProgramController } from './program.controller';
import { BaseApiRoutes } from '../common/base.routes';

class ProgramRoutes extends BaseApiRoutes {
	constructor() {
		super('/programs');
	}

	protected initializeRoutes(): void {
		const controller = new ProgramController();
		this.addRestRoutes(controller, {
			index: [],
			show: [],
			create: [],
			update: [],
			destroy: [],
		});
	}
}

export default new ProgramRoutes().router;
