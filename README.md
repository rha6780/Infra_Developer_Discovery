# Infra_Developer_Discovery

- Developer Discovery 관련 인프라를 관리합니다.
- Terraform 을 이용합니다.
- 실행 전에 development_setup 레포에서 awscli, tfenv 를 설치해야합니다.
- `export AWS_PROFILE=ddprod` 를 통해서 실행 전 프로필 설정을 해주어야 합니다.

```
prod
└── services
    ├── ec2
    ├── ecr
    └── iam

```