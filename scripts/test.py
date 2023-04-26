import click
from DbTest import DbConnect


@click.group(chain=True)
@click.option(
    '-e', '--env',
    default=None,
    help='Path to .env file',
    required=False
)
@click.pass_context
def cli(ctx, env=None):
    """Entrypoint of management CLI command."""
    if env:
        print('here')


@cli.command()
@click.option('--endpoint', help='Endpoint of the DB to Connect', required=True)
@click.option('--port', help='Port of the DB to Connect', required=False)
@click.option('--user', help='IAM User to Connect to DB', required=True)
@click.option('--region', help='Region of the RDS Server', required=True)
@click.option('--dbname', help='Database Name of the RDS Server', required=True)
@click.pass_context
def connect(ctx, endpoint, port, user, region, dbname):
    """ Connection Test For RDS Instance \f
    :param endpoint: Endpoint of the DB to Connect
    :param port: Port of the DB to Connect
    :param user: IAM User to Connect to DB
    :param region: Region of the RDS Server
    :param dbname: Database Name of the RDS Server
    """
    dbtest = DbConnect(endpoint=endpoint, user=user, region=region, dbname=dbname, port=port)
    dbtest.test()
    dbtest.connect()


if __name__ == "__main__":
    cli()
