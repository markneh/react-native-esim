import { NativeModules } from 'react-native';

type EsimType = {
  multiply(a: number, b: number): Promise<number>;
};

const { Esim } = NativeModules;

export default Esim as EsimType;
