import { BaseController } from '../common/base.controller';
import { Program } from '../models';

export class ProgramController extends BaseController {
	constructor() {
		super(Program);
	}
}
