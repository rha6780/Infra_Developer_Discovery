# Infra_Developer_Discovery

<img width="760" alt="Infra_Developer_Discovery_architecture" src="https://github.com/rha6780/Infra_Developer_Discovery/assets/47859845/f49f86a1-f243-4a2a-b8ae-eef58c5d2b93">


- Developer Discovery 관련 인프라를 관리합니다.
- Terraform 을 이용합니다.
- 실행 전에 development_setup 레포에서 awscli, tfenv 를 설치해야합니다.
- `export AWS_PROFILE=ddprod` 를 통해서 실행 전 프로필 설정을 해주어야 합니다.

```
prod
└── services
    ├── codedeploy
    ├── ec2
    ├── ecr
    ├── iam
    └── rds

```
