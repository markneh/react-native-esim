import { NativeModules } from 'react-native';

const { RNESimManager } = NativeModules;

export type EsimConfig = {
  address: string;
  confirmationCode?: string;
  eid?: string;
  iccid?: string;
  matchingId?: string;
  oid?: string;
};

export enum EsimSetupResultStatus {
  Unknown = 0,
  Fail = 1,
  Success = 2,
}

type EsimManager = {
  setupEsim(config: EsimConfig): Promise<EsimSetupResultStatus | never>;
  isEsimSupported(): Promise<boolean | never>;
};

export default RNESimManager as EsimManager;
