-- パスワードは 'password' をBCryptでハッシュ化したもの
-- 管理者ユーザー (ROLE_ADMIN, ROLE_USER)
INSERT INTO t_users (username, password, enabled)
VALUES ('admin', '$2b$12$iq2u42y/l/Y/iNfq1PTZxOf6Q1BgIoSrmBkrnRqt5vSS3c1VYLZNS', true)
ON CONFLICT (username) DO NOTHING;

INSERT INTO t_authorities (username, authority)
VALUES ('admin', 'ROLE_ADMIN'), ('admin', 'ROLE_USER')
ON CONFLICT (username, authority) DO NOTHING;


-- 一般ユーザー (ROLE_USER)
INSERT INTO t_users (username, password, enabled)
VALUES ('user', '$2b$12$iq2u42y/l/Y/iNfq1PTZxOf6Q1BgIoSrmBkrnRqt5vSS3c1VYLZNS', true)
ON CONFLICT (username) DO NOTHING;

INSERT INTO t_authorities (username, authority)
VALUES ('user', 'ROLE_USER')
ON CONFLICT (username, authority) DO NOTHING;


-- 登録クライアント: WebApp (機密クライアント)
-- client_secretは 'secret' をBCryptでハッシュ化したもの
INSERT INTO oauth2_registered_client (id, client_id, client_id_issued_at, client_secret, client_secret_expires_at, client_name, client_authentication_methods, authorization_grant_types, redirect_uris, scopes, client_settings, token_settings)
VALUES (
    'oidc-client-1',
    'webapp-client',
    NOW(),
    '$2b$12$KGigkFRmPqg49A/4CMPMduE6bd.WhpGLwcpS1CP.tEpdo86Kt.dvS',
    NULL,
    'Web App Client',
    'client_secret_basic',
    'refresh_token,authorization_code',
    'http://127.0.0.1:8080/login/oauth2/code/messaging-client-oidc',
    'openid,profile,message.read,message.write',
    '{"@class":"java.util.Collections$UnmodifiableMap","settings.client.require-proof-key":false,"settings.client.require-authorization-consent":true}',
    '{"@class":"java.util.Collections$UnmodifiableMap","settings.token.access-token-format":{"@class":"org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat","value":"self-contained"},"settings.token.access-token-time-to-live":["java.time.Duration",300],"settings.token.refresh-token-time-to-live":["java.time.Duration",3600],"settings.token.reuse-refresh-tokens":false,"settings.token.authorization-code-time-to-live":["java.time.Duration",300]}'
)
ON CONFLICT (id) DO NOTHING;


-- 登録クライアント: SPA (公開クライアント, PKCE必須)
INSERT INTO oauth2_registered_client (id, client_id, client_id_issued_at, client_secret, client_secret_expires_at, client_name, client_authentication_methods, authorization_grant_types, redirect_uris, post_logout_redirect_uris, scopes, client_settings, token_settings)
VALUES (
    'oidc-client-2',
    'spa-client',
    NOW(),
    NULL, -- 公開クライアントなのでシークレットはNULL
    NULL,
    'SPA Client',
    'none',
    'refresh_token,authorization_code',
    'http://127.0.0.1:3000/callback',
    'http://127.0.0.1:3000/logout',
    'openid,profile,message.read',
    '{"@class":"java.util.Collections$UnmodifiableMap","settings.client.require-proof-key":true,"settings.client.require-authorization-consent":true}',
    '{"@class":"java.util.Collections$UnmodifiableMap","settings.token.authorization-code-time-to-live":["java.time.Duration",300],"settings.token.access-token-format":{"@class":"org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat","value":"self-contained"},"settings.token.access-token-time-to-live":["java.time.Duration",300],"settings.token.refresh-token-time-to-live":["java.time.Duration",3600],"settings.token.reuse-refresh-tokens":true,"settings.token.authorization-code-time-to-live":["java.time.Duration",300]}'
)
ON CONFLICT (id) DO NOTHING;
